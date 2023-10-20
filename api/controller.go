package api

import (
	"fmt"
	"html/template"
	"log"
	"math/rand"
	"net/http"
	"wb_task_l0/streaming"

	"github.com/nats-io/stan.go"
)

func StartPage(w http.ResponseWriter, r *http.Request) {
	tml, err := template.ParseFiles("templates/main.html")
	if err != nil {
		log.Fatal(err)
	}
	tml.Execute(w, nil)
}

// Make a new connection to the STAN server, create a new subscriber and send the data to the Web
func sendDataHandler(w http.ResponseWriter, r *http.Request) {
	clientName := fmt.Sprintf("client-%d", rand.Int())
	sc, err := stan.Connect("mystreamingserver", clientName)
	if err != nil {
		log.Fatal(err)
	}
	sub := streaming.NewSubscriber(&sc, clientName)
	orderId := r.FormValue("orderId")

	order := sub.Subscribe(orderId)
	fmt.Fprintf(w, "orderID: %s DateCreated: %s DeliveryService: %s \n", order.OrderId, order.DateCreated, order.DeliveryService)
	fmt.Fprintf(w, "NameDelivery: %s Phone: %s \n", order.DeliveryId.NameDelivery, order.DeliveryId.Phone)
	for i := 0; i < len(order.Items); i++ {
		fmt.Fprintf(w, "Name: %s Price: %d Brand: %s \n", order.Items[i].NameItem, order.Items[i].Price, order.Items[i].Brand)
	}
}
