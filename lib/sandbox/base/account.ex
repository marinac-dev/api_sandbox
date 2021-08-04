defmodule Sandbox.Base.Account do
  @type t :: %__MODULE__{
          account_number: integer(),
          balances: map(),
          currency_code: String.t(),
          enrollment_id: String.t(),
          id: String.t(),
          institution: map(),
          links: map(),
          name: String.t(),
          routing_numbers: map()
        }

  defstruct [
    :account_number,
    :balances,
    :currency_code,
    :enrollment_id,
    :id,
    :institution,
    :links,
    :name,
    :routing_numbers
  ]

  def all_names(),
    do: ["Jimmy Carter", "Ronald Reagan", "George H. W. Bush", "Bill Clinton", "George W. Bush", "Barack Obama", "Donald Trump"]

  def all_institutions(),
    do: ["Chase", "Bank of America", "Wells Fargo", "Citi", "Capital One"]

  def all_merchants() do
    [
      "Uber",
      "Uber Eats",
      "Lyft",
      "Five Guys",
      "In-N-Out Burger",
      "Chick-Fil-A",
      "AMC Metreon",
      "Apple",
      "Amazon",
      "Walmart",
      "Target",
      "Hotel Tonight",
      "Misson Ceviche",
      "The Creamery",
      "Caltrain",
      "Wingstop",
      "Slim Chickens",
      "CVS",
      "Duane Reade",
      "Walgreens",
      "Rooster & Rice",
      "McDonald's",
      "Burger King",
      "KFC",
      "Popeye's",
      "Shake Shack",
      "Lowe's",
      "The Home Depot",
      "Costco",
      "Kroger",
      "iTunes",
      "Spotify",
      "Best Buy",
      "TJ Maxx",
      "Aldi",
      "Dollar General",
      "Macy's",
      "H.E. Butt",
      "Dollar Tree",
      "Verizon Wireless",
      "Sprint PCS",
      "T-Mobile",
      "Kohl's",
      "Starbucks",
      "7-Eleven",
      "AT&T Wireless",
      "Rite Aid",
      "Nordstrom",
      "Ross",
      "Gap",
      "Bed, Bath & Beyond",
      "J.C. Penney",
      "Subway",
      "O'Reilly",
      "Wendy's",
      "Dunkin' Donuts",
      "Petsmart",
      "Dick's Sporting Goods",
      "Sears",
      "Staples",
      "Domino's Pizza",
      "Pizza Hut",
      "Papa John's",
      "IKEA",
      "Office Depot",
      "Foot Locker",
      "Lids",
      "GameStop",
      "Sephora",
      "MAC",
      "Panera",
      "Williams-Sonoma",
      "Saks Fifth Avenue",
      "Chipotle Mexican Grill",
      "Exxon Mobil",
      "Neiman Marcus",
      "Jack In The Box",
      "Sonic",
      "Shell"
    ]
  end

  def create(params) do
    %__MODULE__{
      account_number: params.account_number,
      balances: params.balances,
      currency_code: params.currency_code,
      enrollment_id: params.enrollment_id,
      id: params.id,
      institution: params.institution,
      links: params.links,
      name: params.name,
      routing_numbers: params.routing_numbers
    }
  end
end

defimpl Jason.Encoder, for: Sandbox.Base.Account do
  def encode(value, opts) do
    Jason.Encode.map(
      Map.take(value, [
        :account_number,
        :balances,
        :currency_code,
        :enrollment_id,
        :id,
        :institution,
        :links,
        :name,
        :routing_numbers
      ]),
      opts
    )
  end
end
