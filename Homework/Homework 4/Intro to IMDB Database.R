library(DBI)
library(dplyr, warn.conflicts = FALSE)

##### Establishing the connection
con <- dbConnect(RMariaDB::MariaDB(),
	host = "relational.fel.cvut.cz",
	port = 3306,
	username = "guest",
	password = "ctu-relational",
	dbname = "imdb_ijs"
)

# If you do not submit requests for a
# few minutes, the server will idle
# and you will receive the error
# "Error: Server has gone away [2006]".
# Just rerun the dbConnect() command to
# reestablish connection.

# Don't forget to disconnect manually too
# when done with the connection.


##### DBI commands to view schema info
dbListTables(con)
dbListFields(con, "movies")

##### MySQL commands to view schema info
dbGetQuery(con, "SHOW TABLES;")
dbGetQuery(con, "DESCRIBE movies;")


# Question: How many movies have a
# rating/rank of at least 7.0?

##### With DBI
dbGetQuery(con, "
	SELECT COUNT(rank)
	FROM movies
	WHERE rank >= 7.0
")


##### With dplyr/dbplyr
movies <- tbl(con, "movies")
movies_high_rank <- movies |> 
	filter(rank >= 7.0) |>
	summarize(cnt_rank = count(rank))
movies_high_rank |> show_query()
movies_high_rank |> collect()