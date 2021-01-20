package db

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

var ErrNoMatch = fmt.Errorf("no matching record")

type Database struct {
	Conn *sql.DB
}

func Initialize(dbhost, username, password, database string, dbport int) (Database, error) {
	db := Database{}
	dsn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		dbhost, dbport, username, password, database)
	conn, err := sql.Open("postgres", dsn)
	if err != nil {
		return db, err
	}

	db.Conn = conn
	err = db.Conn.Ping()
	if err != nil {
		return db, err
	}
	log.Println("Database connection established")
	return db, nil
}
