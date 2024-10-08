postgres:
	docker run --name postgres12 -p 5433:5432 -e POSTGRES_PASSWORD=newpassword -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it postgres12 dropdb simple_bank
migrateup:
	 migrate -path ./db/migration -database "postgresql://postgres:newpassword@localhost:5433/simple_bank?sslmode=disable" -verbose up
migrateup1:
	 migrate -path ./db/migration -database "postgresql://postgres:newpassword@localhost:5433/simple_bank?sslmode=disable" -verbose up 1
migratedown:
	 migrate -path ./db/migration -database "postgresql://postgres:newpassword@localhost:5433/simple_bank?sslmode=disable" -verbose down
migratedown1:
	 migrate -path ./db/migration -database "postgresql://postgres:newpassword@localhost:5433/simple_bank?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/jiarui/simplebank/db/sqlc Store
.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc server mock
