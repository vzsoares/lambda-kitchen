package main

import (
	"encoding/json"
	"io"
	"net/http"

	"lambdas/go-monolithic-http-terraform/store"
	"lambdas/go-monolithic-http-terraform/types"
)

type handler func(w http.ResponseWriter, r *http.Request)

func HttpRespond(w http.ResponseWriter, s int, j interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(s)
	json.NewEncoder(w).Encode(j)
}

var GetProduct handler = func(w http.ResponseWriter, r *http.Request) {

	id := r.URL.Query().Get("id")

	if id == "" {
		HttpRespond(w, http.StatusNotFound, nil)
		return
	}

	p, err := store.NewMemoryStore().Get(id)
	if err != nil {
		HttpRespond(w, http.StatusInternalServerError, err.Error())
		return
	}

	HttpRespond(w, http.StatusOK, p)
}

var PutProduct handler = func(w http.ResponseWriter, r *http.Request) {
	b, err := io.ReadAll(r.Body)
	if err != nil {
		HttpRespond(w, http.StatusInternalServerError, "Unknown error")
		return
	}

	if string(b) == "" {
		HttpRespond(w, http.StatusBadRequest, "No body")
		return
	}

	product := types.Product{}
	if err := json.NewDecoder(r.Body).Decode(&product); err != nil {
		HttpRespond(w, http.StatusInternalServerError, err.Error())
		return
	}

	err = store.NewMemoryStore().Put(product)
	if err != nil {
		HttpRespond(w, http.StatusInternalServerError, err.Error())
		return
	}

	HttpRespond(w, http.StatusOK, nil)
}
