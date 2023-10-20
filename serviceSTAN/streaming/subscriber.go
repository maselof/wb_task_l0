package streaming

import (
	"encoding/json"
	"fmt"
	"log"
	"time"
	models "wb_task_l0/database"

	"github.com/nats-io/stan.go"
)

type Subscriber struct {
	name string
	conn *stan.Conn
}

// Adding a new Subscriber
func NewSubscriber(sc *stan.Conn, name string) *Subscriber {
	return &Subscriber{
		name: name,
		conn: sc,
	}
}

// Getting data from channel
func (s *Subscriber) Subscribe(nameChannel string) models.Orders {
	order := models.Orders{}
	sub, err := (*s.conn).Subscribe(fmt.Sprintf("wb.%s", nameChannel), func(m *stan.Msg) {
		err := json.Unmarshal(m.Data, &order)
		if err != nil {
			log.Fatal(err)
		}
	}, stan.StartWithLastReceived(),
		stan.AckWait(time.Second*3),
		stan.SetManualAckMode(),
		stan.MaxInflight(10))
	if err != nil {
		log.Fatal(err)
	}
	time.Sleep(time.Second) // waiting for a message from the channel
	defer sub.Unsubscribe()
	return order
}
