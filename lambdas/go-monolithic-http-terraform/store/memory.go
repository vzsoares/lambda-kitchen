package store

import (
	"encoding/json"
	"errors"
	"lambdas/go-monolithic-http-terraform/types"
	"os"
	"path"
)

type MemoryStore struct {
	store map[string]types.Product
}

var _ types.Store = (*MemoryStore)(nil)

func LoadFakeDb() map[string]types.Product {
	bytes, err := os.ReadFile(path.Join("./", "db.stub.json"))
	if err != nil {
		panic(err.Error())
	}

	var data []types.Product
	err = json.Unmarshal(bytes, &data)

	result := make(map[string]types.Product)
	for d := 0; d < len(data); d++ {
		target := data[d]
		result[target.Id] = target
	}
	return result
}

func NewMemoryStore() *MemoryStore {
	fakeData := LoadFakeDb()
	return &MemoryStore{store: fakeData}
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
