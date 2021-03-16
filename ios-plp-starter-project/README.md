# ios-test

## API

The API has basic authentication. The username is `admin` and the password is `password`

The base url is:
`http://admin:password@interview-tech-testing.herokuapp.com`

Hitting this endpoint will confirm the status of the service, you should see "Service is running"

### `/api/products`

__Request:__

```sh
curl -X GET http://admin:password@interview-tech-testing.herokuapp.com/api/products
```

__Response:__

```json
{
    "products": [
        {
            "id": "2",
            "image_key": "SD_01_T38_1502_Y0_X_EC_0",
            "name": "Round Neck Jumper",
            "offer_ids": [
                "2",
                "3",
                "5",
                "4"
            ],
            "price": {
                "currency_code": "GBP",
                "current_price": 1250,
                "original_price": 1400
            }
        }
    ]
}
```

### `/api/product/{n}`

__Request:__

```sh
curl -X GET http://admin:password@interview-tech-testing.herokuapp.com/api/product/2
```

__Response:__

```json
{
    "id": "2",
    "image_key": "SD_01_T38_1502_QA_X_EC_90",
    "information": [
        {
            "section_text": "A chic and versatile addition to any wardrobe, this long sleeved jumper is wonderfully soft to give your outfits as much style as comfort and has been treated with our StaySoft™ technology so it stays that way even after repeated washes. With ribbed trims and a comfy regular fit, this women’s jumper is sure to become your new staple.\r\n\r\nCare and composition\r\nComposition\r\n100% acrylic\r\nCare instructions\r\nMachine washable even at 30º\r\nTumble dry\r\nKeep away from fire and flames\r\n\r\nItem details\r\nModel Height: 5ft 9\"/175cm\r\nModel is wearing size: 8\r\n\r\nFit and style\r\nProduct Style: Jumpers\r\nRegular fit\r\nNeck to hem length: 61cm\r\nThe length measurement above relates to a size 12 regular. Length will vary slightly according to size\r\nRibbed trim\r\n",
            "section_title": ""
        }
    ],
    "name": "Round Neck Jumper",
    "price": {
        "currency_code": "GBP",
        "current_price": 1250,
        "original_price": 1400
    }
}
```

### `/api/user/{n}/offers`

__Request:__

```sh
curl -X GET http://admin:password@interview-tech-testing.herokuapp.com/api/user/2/offers
```

__Response:__

```json
{
    "available_badges": "loyalty:SLOTTED,BONUS||sale:PRIORITY_ACCESS,REDUCED",
    "offers": [
        {
            "id": "6",
            "title": "Reductions!",
            "type": "REDUCED"
        },
        {
            "id": "7",
            "title": "Special!",
            "type": "BONUS"
        },
        {
            "id": "3",
            "title": "Priority Access!",
            "type": "PRIORITY_ACCESS"
        }
    ]
}
```
