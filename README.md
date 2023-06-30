# Iniciador Elixir SDK

Welcome to the Iniciador Elixir SDK! This tool is made for Elixir
developers who want to easily integrate with our API.

If you have no idea what Iniciador is, check out our [website](https://www.iniciador.com.br/)

## 1. Description

The Iniciador SDK is a Elixir library that provides a convenient way to interact with the Iniciador API.

## 2. Installation

The package can be installed by adding `iniciador` to your list of dependencies in `mix.exs`:

```elixir
def  deps  do
  [
	{:iniciador, "~> 0.1.0"}
  ]
end
```

## 3. Setting up credentials

Set your credentials in your `config/config.exs` :

```elixir
import Config

config :iniciador,
  client_id: "client_id",
  client_secret: "client_secret",
  env: :dev # it can be :dev | :stag | :sandbox | :prod
```

## 4. Usage

### 4.1 Whitelabel

#### 4.1.1 Authentication

To authenticate with the Iniciador Whitelabel, use the `Iniciador.Auth.auth_interface` method:

```elixir
{:ok,%Iniciador.AccessToken{interface_url: interface_url, access_token: access_token, payment_id: payment_id}} = Iniciador.Auth.auth_interface(%{})
```

- Use `interface_url` to complete the payment flow

#### 4.1.2 Payments

To use payments services with the Iniciador Whitelabel, use the `Payment` module:

##### 4.1.2.1 `get`

To get the payment details use `get` method

```elixir
{:ok, payment} = Iniciador.Payment.get(access_token)
```

##### 4.1.2.2 `status`

to get the payment status details use `status` method

```elixir
{:ok, payment_status} = Iniciador.Payment.status(access_token)
```

### 4.2 API Only

#### 4.2.1 Authentication

To authenticate with the Iniciador API, use the `auth` method:

```elixir
{:ok,%Iniciador.AccessToken{access_token: access_token, payment_id: payment_id}} = Iniciador.Auth.auth()
```

#### 4.2.2 Participants

To get participants with the Iniciador API, use the `Participants` module:

```elixir
{:ok, participants_response} = Iniciador.Participants.list(access_token, %{limit: 50})
```

#### 4.2.3 Payments

To use payments services with the Iniciador API, use the `Payment` module:

##### 4.2.3.1 `send`

To send the payment for processing use `send` method

```elixir
{:ok, payment} = Iniciador.Payment.send(access_token)
```

##### 4.2.3.2 `get`

To get the payment details use `get` method

```elixir
{:ok, payment} = Iniciador.Payment.get(access_token)
```

##### 4.2.3.3 `status`

to get the payment status details use `status` method

```elixir
{:ok, payment_status} = Iniciador.Payment.status(access_token)
```

## Help and Feedback

If you have any questions or need assistance regarding our SDK, please don't hesitate to reach out to us. Our dedicated support team is here to help you integrate with us as quickly as possible. We strive to provide prompt responses and excellent support.

We also highly appreciate any feedback you may have. Your thoughts and suggestions are valuable to us as we continuously improve our SDK and services. We welcome your input and encourage you to share your thoughts with us.

Feel free to contact us by sending an email to suporte@iniciador.com.br. We look forward to hearing from you and assisting you with your integration.
