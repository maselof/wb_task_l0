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
	tml, err := template.ParseFiles("templates/main.html")
	if err != nil {
		log.Fatal(err)
	}
	tml.Execute(w, order)
}
