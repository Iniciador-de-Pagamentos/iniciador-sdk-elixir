defmodule Iniciador.Payment.PaymentInitiation do
  defstruct id: nil,
            created_at: nil,
            updated_at: nil,
            error: nil,
            status: nil,
            redirect_consent_url: nil,
            external_id: nil,
            end_to_end_id: nil,
            client_id: nil,
            customer_id: nil,
            provider: nil,
            consent_id: nil,
            payment_id: nil,
            participant_id: nil,
            user: nil,
            business_entity: nil,
            method: nil,
            pix_key: nil,
            amount: nil,
            date: nil,
            description: nil,
            metadata: nil,
            redirect_url: nil,
            redirect_on_error_url: nil,
            ibge: nil,
            debtor: nil,
            creditor: nil,
            fee: nil

  @type t :: %__MODULE__{}
end
