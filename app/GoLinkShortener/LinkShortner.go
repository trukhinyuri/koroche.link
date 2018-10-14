package main

import (
	"flag"
	"log"
	"net/http"
	"time"
)

var (
	dynamoRegion   = flag.String("dynamo-region", "eu-west-1", "AWS region where DynamoDB database is hosted.")
	dynamoTable    = flag.String("dynamo-table", "url_shortener", "DynamoDB Table to store shortened urls.")
	dynamoEndpoint = flag.String("dynamo-endpoint", "", "Optional, address for (local) DynamoDB, if using AWS declaring the region will suffice.")
	redisEndpoint  = flag.String("redis-endpoint", "127.0.0.1:6379", "Redis database address.")
	port           = flag.String("port", "5100", "App port.")
)

//type Config struct {
//	Port string `json:"port"`
//	DynamoRegion string `json:"dynamoRegion"`        //AWS region where DynamoDB database is hosted.
//	DynamoTable string `json:"dynamoTable"`          //DynamoDB Table to store shortened urls.
//	DynamoEndpoint string `json:"dynamoEndpoint"`    //Optional, address for (local) DynamoDB, if using AWS declaring the region will suffice.
//	RedisEndpoint string `json:"RedisEndpoint"`      //Redis database address.
//}

//func LoadConfiguration(file string) Config {
//	var config Config
//	configFile, err := os.Open(file)
//	defer configFile.Close()
//	if err != nil {
//		fmt.Println(err.Error())
//	}
//	jsonParser := json.NewDecoder(configFile)
//	jsonParser.Decode(&config)
//	return config
//}

/*
	This is the entry point for the API, the purpose of the API is to shorten url links via a REST HTTP request
	Once the code is built and running, to create a short url to a long url mapping, send a POST request to http://localhost:5100/Create, the POST request should include the shortUrl and the longUrl as follows:
	{'shorturl':'cosmosfading','longurl':'https://cosmosmagazine.com/space/universe-slowly-fading-away'}

	You could then consume a shorturl by issuing a GET request to http://localhost:5100/<the short url>
	The program makes use of the gorilla mux library for routing as well as the mgo library to interface with mongo database
*/
func main() {

	flag.Parse()
	//
	//config := LoadConfiguration("config.json");
	//fmt.Println(config.DynamoRegion);
	//dynamoRegion = &config.DynamoRegion
	//dynamoTable = &config.DynamoTable
	//dynamoEndpoint = &config.DynamoEndpoint
	//redisEndpoint = &config.RedisEndpoint

	//Create a new API shortner API
	LinkShortener := NewUrlLinkShortenerAPI()
	//Create the needed routes for the API
	routes := CreateRoutes(LinkShortener)
	//Initiate the API routers
	router := NewLinkShortenerRouter(routes)
	//This will start the web server on local port 5100
	srv := &http.Server{
		Handler: router,
		Addr:    ":" + *port,
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 5 * time.Second,
		ReadTimeout:  5 * time.Second,
	}
	log.Fatal(srv.ListenAndServe())
}
