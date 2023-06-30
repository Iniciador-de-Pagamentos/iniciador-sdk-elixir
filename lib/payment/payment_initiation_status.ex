defmodule Iniciador.Payment.PaymentInitiationStatus do
  defstruct id: nil,
            consent_id: nil,
            date: nil,
            created_at: nil,
            updated_at: nil,
            end_to_end_id: nil,
            transaction_identification: nil,
            status: nil,
            amount: nil,
            error: nil,
            redirect_consent_url: nil,
            external_id: nil

  @type t :: %__MODULE__{}
end
