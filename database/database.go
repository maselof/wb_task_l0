package database

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

const (
	user     = "maselof"
	password = "maselof"
	nameDB   = "wb_orders"
)

func ConnectToDB() *sql.DB {
	connStr := fmt.Sprintf("postgres://%s:%s@localhost/%s?sslmode=disable", user, password, nameDB)
	pl, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	return pl
}
