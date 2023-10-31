package main

import (
	"context"
	"encoding/json"
	"os"
	"strconv"
	"time"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/google/uuid"
)

type User struct {
	Name string `json:"name"`
	Cpf  string `json:"cpf"`
	Age  string `json:"age"`
}

func HandleRequest(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var user User

	if err := json.Unmarshal([]byte(request.Body), &user); err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       "Invalid request body",
		}, nil
	}

	if user.Name == "" || user.Age == "" || user.Cpf == "" {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Body:       "Request Not Valid",
		}, nil
	}

	ID := uuid.New().String()
	currentTime := time.Now().String()
	ClientSize := currentTime
	sess := session.Must(session.NewSession())
	svc := dynamodb.New(sess)

	item := map[string]*dynamodb.AttributeValue{
		"id": {
			S: aws.String(ID),
		},
		"name": {
			S: aws.String(user.Name),
		},
		"cpf": {
			S: aws.String(user.Cpf),
		},
		"age": {
			S: aws.String(user.Age),
		},
		"clientsize": {
			S: aws.String(ClientSize),
		},
		"statusaccount": {
			BOOL: aws.Bool(false),
		},
		"ebankActive": {
			BOOL: aws.Bool(false),
		},
		"balance": {
			N: aws.String(strconv.Itoa(0)),
		},
		"profile": {
			S: aws.String("infrequent"),
		},
	}

	_, err := svc.PutItemWithContext(ctx, &dynamodb.PutItemInput{
		TableName: aws.String(os.Getenv("DYNAMODB_USERS_TABLE")),
		Item:      item,
	})

	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 500,
			Body:       "Error Insert User in DynamoDb",
		}, err
	}

	responseBody := map[string]string{"message": "Usuário inserido com sucesso!"}
	responseJSON, _ := json.Marshal(responseBody)

	return events.APIGatewayProxyResponse{
		StatusCode: 201,
		Body:       string(responseJSON),
	}, nil
}

func main() {
	lambda.Start(HandleRequest)
}