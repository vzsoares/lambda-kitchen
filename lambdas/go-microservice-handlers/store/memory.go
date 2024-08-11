package store

import (
	"errors"
	"lambdas/go-microservice-handlers/types"
)

type MemoryStore struct {
	store map[string]types.Product
}

var _ types.Store = (*MemoryStore)(nil)

func NewMemoryStore() *MemoryStore {
	return &MemoryStore{}
}
func (s *MemoryStore) Put(p types.Product) error {
	s.store[p.Id] = p

	return nil
}
func (s *MemoryStore) Get(id string) (*types.Product, error) {
	p, ok := s.store[id]
	if !ok {
		return nil, errors.New("not found")
	}

	return &p, nil
}
