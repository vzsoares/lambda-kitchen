package types

type Store interface {
	Put(Product) error
	Get(string) (*Product, error)
}
