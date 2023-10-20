package api

import (
	"fmt"
	"html/template"
	"log"
	"math/rand"
	"net/http"
	models "wb_task_l0/database"
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
	orderId := r.FormValue("orderId")
	var resChan chan models.Orders = make(chan models.Orders)

	go connectAndCreateSubscriber(orderId, resChan)
	order, opened := <-resChan
	if !opened {
		log.Fatal("Channel is closed")
	}

	tml, err := template.ParseFiles("templates/main.html")
	if err != nil {
		log.Fatal(err)
	}
	tml.Execute(w, order)
}

func connectAndCreateSubscriber(orderId string, ch chan models.Orders) {
	clientName := fmt.Sprintf("client-%d", rand.Int())
	sc, err := stan.Connect("mystreamingserver", clientName)
	if err != nil {
		log.Fatal(err)
	}
	sub := streaming.NewSubscriber(&sc, clientName)
	order := sub.Subscribe(orderId)
	ch <- order
}
