package serverSTAN

import (
	stand "github.com/nats-io/nats-streaming-server/server"
	stores "github.com/nats-io/nats-streaming-server/stores"
)

// Starting the STAN server with its own settings
func RunServer(id string) (*stand.StanServer, error) {
	opts := stand.GetDefaultOptions()
	opts.StoreType = stores.TypeMemory // we specify that the data is stored in memory
	opts.ID = id
	s, err := stand.RunServerWithOpts(opts, nil)
	if err != nil {
		return nil, err
	}
	return s, nil
}
