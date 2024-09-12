postgres:
	docker run --name postgres12 -p 5433:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it postgres12 dropdb simple_bank
migrateup:
	migrate -path ./db/migrations -database "postgresql://postgres:mysecretpassword@localhost:5433/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path ./db/migrations -database "postgresql://postgres:mysecretpassword@localhost:5433/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown sqlc