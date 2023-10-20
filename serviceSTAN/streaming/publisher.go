package streaming

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	models "wb_task_l0/database"

	"github.com/nats-io/stan.go"
)

type Publisher struct {
	conn *stan.Conn
	name string
}

// Adding a new Publisher
func NewPublisher(c *stan.Conn) *Publisher {
	return &Publisher{
		conn: c,
		name: "Publisher",
	}
}

// Write data from database in memory STAN server
func (p *Publisher) WriteToSTANCache(pl *sql.DB) {
	rowsOrders, err := pl.Query("SELECT * FROM orders;")
	if err != nil {
		log.Fatal(err)
	}
	defer rowsOrders.Close()

	orders := []models.Orders{}

	for rowsOrders.Next() {
		order := models.Orders{}
		delivery := models.Delivery{}
		items := []models.Items{}
		item := models.Items{}
		payment := models.Payment{}
		var deliveryId int
		err := rowsOrders.Scan(&order.OrderId, &order.Entry, &order.Locale, &order.InternalSignature, &order.CostumerId,
			&order.DeliveryService, &order.ShardKey, &order.SmId, &order.DateCreated, &order.OofShard, &deliveryId)
		if err != nil {
			log.Println(err)
		}
		rowDelivery, err := pl.Query(fmt.Sprintf("SELECT * FROM delivery WHERE id = %v", deliveryId))
		if err != nil {
			log.Fatalf("Can't read data from Delivery: %s", err)
		}
		for rowDelivery.Next() {
			err := rowDelivery.Scan(&delivery.Id, &delivery.NameDelivery, &delivery.Phone, &delivery.Zip, &delivery.City,
				&delivery.Address, &delivery.Region, &delivery.Email)
			if err != nil {
				log.Printf("Delivery: %s", err)
			}
		}
		order.DeliveryId = delivery
		rowsItems, err := pl.Query(fmt.Sprintf(`SELECT chrt_id, price, rid, name_item, sale, size_item, total_price, nm_id, brand, status 
		FROM items JOIN orders_items_relaship ON items.chrt_id = orders_items_relaship.item_id 
		WHERE orders_items_relaship.order_id = '%s'`, order.OrderId))
		if err != nil {
			log.Fatalf("Can't read data from Items: %s", err)
		}
		for rowsItems.Next() {
			err := rowsItems.Scan(&item.ItemId, &item.Price, &item.Rid, &item.NameItem, &item.Sale, &item.SizeItem,
				&item.TotalPrice, &item.NmId, &item.Brand, &item.Status)
			if err != nil {
				log.Printf("Items: %s", err)
			}
			items = append(items, item)
		}
		order.Items = items
		rowPayment, err := pl.Query(fmt.Sprintf("SELECT * FROM payment WHERE transaction_payment = '%s'", order.OrderId))
		if err != nil {
			log.Fatalf("Can't read data from Payment: %s", err)
		}
		for rowPayment.Next() {
			err := rowPayment.Scan(&payment.TransactionPayment, &payment.RequestID, &payment.Currency,
				&payment.Provider, &payment.Amount, &payment.PaymentDt, &payment.Bank, &payment.DeliveryCost, &payment.GoodsTotal, &payment.CustomFee)
			if err != nil {
				log.Printf("Payment: %s", err)
			}
		}
		order.Payment = payment
		orders = append(orders, order)
	}
	for i := 0; i < len(orders); i++ {
		orderJSON, err := json.Marshal(orders[i])
		if err != nil {
			log.Fatalf("Can't write STRUCTUR to JSON: %s", err)
		}
		log.Println(orders[i].OrderId)
		(*p.conn).Publish(fmt.Sprintf("wb.%s", orders[i].OrderId), orderJSON)
	}
}
