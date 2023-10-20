package database

//Models of all tables from the database and all attributes from JSON

type Orders struct {
	OrderId           string
	Entry             string
	Locale            string
	InternalSignature string
	CostumerId        string
	DeliveryService   string
	ShardKey          string
	SmId              int
	DateCreated       string
	OofShard          string
	DeliveryId        Delivery
	Items             []Items
	Payment           Payment
}

type Items struct {
	ItemId     int
	Price      int
	Rid        string
	NameItem   string
	Sale       int
	SizeItem   string
	TotalPrice int
	NmId       int
	Brand      string
	Status     int
}

type Delivery struct {
	Id           int
	NameDelivery string
	Phone        string
	Zip          string
	City         string
	Address      string
	Region       string
	Email        string
}

type Payment struct {
	TransactionPayment string
	RequestID          string
	Currency           string
	Provider           string
	Amount             int
	PaymentDt          int
	Bank               string
	DeliveryCost       int
	GoodsTotal         int
	CustomFee          int
}
