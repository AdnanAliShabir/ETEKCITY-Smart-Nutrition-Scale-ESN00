# ETEKCITY-Smart-Nutrition-Scale-ESN00-
ETEKCITY smart nutrition scale protocol reverse engneering

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fhertzg%2Fetekcity%2Fbadge%3Fref%3Dmaster&style=flat)](https://actions-badge.atrox.dev/hertzg/etekcity/goto?ref=master)
[![codecov](https://codecov.io/gh/hertzg/node-net-keepalive/branch/master/graph/badge.svg)](https://codecov.io/gh/hertzg/node-net-keepalive)


This project aims to reverse engineer the BLE protocol used by the ETEKCITY Smart Nutrition Scale (ESN00).

[ETEKCITY Smart Nutrition Scale (ESN00)](https://www.etekcity.com/product/100334) ([DE](https://www.amazon.de/gp/product/B07RJV9QPF) | [US](https://www.amazon.com/Etekcity-ESN00-Nutrition-Counting-Bluetooth/dp/B07FCZSC41))

![ETEKCITY Smart Nutrition Scale](https://image.etekcity.com/thumb/201810/28/7f248c75a139b66b9d0e6b081c25a0a1.jpg)

## BLE Protocol

This section provides information on the researched BLE protocol:

### BLE Services & Characteristics

```text
> Service: 00001910-0000-1000-8000-00805f9b34fb
>> Characteristic: 00002c10-0000-1000-8000-00805f9b34fb [READ]
>> Characteristic: 00002c11-0000-1000-8000-00805f9b34fb [WRITEWITHOUTRESPONSE, WRITE]
>> Characteristic: 00002c12-0000-1000-8000-00805f9b34fb [NOTIFY, INDICATE]
> Service: 0000180a-0000-1000-8000-00805f9b34fb
>> Characteristic: 00002a23-0000-1000-8000-00805f9b34fb [READ]
>> Characteristic: 00002a50-0000-1000-8000-00805f9b34fb [READ]
> Service: 00001800-0000-1000-8000-00805f9b34fb
>> Characteristic: 00002a00-0000-1000-8000-00805f9b34fb [READ]
>> Characteristic: 00002a01-0000-1000-8000-00805f9b34fb [READ]

### Packet

![](https://kroki.io/packetdiag/svg/eNorSEzOTi1JyUxMV6jmUlAw0DW2UvBITUxJLbJWQAL6-grO-XnFJYl5JVYKBhVpqalpyQaJRkAdJlYKIZUFqQrRRfkliSWptkbmBrHWEB0BYLPB0kCFplYKPql56SUZaEqBCl0SSxKBkkA5oDotCDc6JzXP1jTWGtkJIAmwCmcPbwwLIY7MSE3OLi7N5arlAgALMjve)

