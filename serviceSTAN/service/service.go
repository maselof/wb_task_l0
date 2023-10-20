package service

import (
	"log"
	"time"
	"wb_task_l0/api"
	"wb_task_l0/database"
	"wb_task_l0/streaming"

	server "wb_task_l0/serverSTAN"

	"github.com/nats-io/stan.go"
)

func RunService() {
	//CONNECT TO DATABASE

	log.Println("TRY CONNECT TO DATABASE")
	pl := database.ConnectToDB()
	defer pl.Close()

	//START STAN SERVER
	s, err := server.RunServer("mystreamingserver")
	if err != nil {
		log.Fatal(err)
	}
	defer s.Shutdown()
	log.Println("START STAN SERVER")

	//CONNECT TO STAN SERVER
	sc, err := stan.Connect(s.ClusterID(), "publisher")
	if err != nil {
		log.Fatal(err)
	}
	defer sc.Close()
	log.Println("CONNECT TO STAN SERVER")

	//PUBLISHED DATA FROM DATABASE TO CACHE STAN
	publisher := streaming.NewPublisher(&sc)
	publisher.WriteToSTANCache(pl)
	time.Sleep(time.Second * 2)

	api.StartApi()
}
