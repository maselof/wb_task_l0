package api

import (
	"net/http"
)

func StartApi() {
	http.HandleFunc("/", StartPage)
	http.HandleFunc("/order", sendDataHandler)
	http.ListenAndServe(":8080", nil)
}
