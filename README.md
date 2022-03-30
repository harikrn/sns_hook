# SNSHook

SNSHook is a simple gem to capture subscription for testing 

## How to run

- Set AWS configuration in enviroment variables
- Run below command to start the server

``` sh
thin -c config/thin.yml start
```

#### Environment variables

```sh
AWS_ACCESS_KEY_ID=YourAccessKey
AWS_SECRET_ACCESS_KEY=YourSecretKey
AWS_REGION=Region

AWS_SNS_HOST=YourServerHostAvailableForAWS-SNS
```

## Aws setups

### Create topic

``` ruby
 client = Aws::SNS::Client.new
 topic = client.create_topic(name: 'standard')
```

### Create subscription

- Use tunnel or make your server public (I used ngrok)

``` ruby
 subscription = client.subscribe(
   topic_arn: topic.topic_arn,
   protocol: 'http'
   endpoint: 'server/sns'
 )
```

### Confirm subscription

- Get the token from the server logs

``` ruby
  subscription = client.confirm_subscription(
    topic_arn: topic.topic_arn, 
    token: token
  )
```

### Publish message 

``` ruby
  client.publish(
    topic_arn: topic.topic_arn,
    message: 'Your messages'
  )
```

