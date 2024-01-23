# ETEKCITY-Smart-Nutrition-Scale-ESN00
ETEKCITY smart nutrition scale protocol reverse engneering

In the iOS app, we have successfully implemented the functionality to read weight from the Etekcity Smart Scale. The WeightScaleManager class handles the BLE communication, and the data packets follow the structure outlined in the protocol section.

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
```

## Protocol

All packets have this structure

### Packet

![](https://kroki.io/packetdiag/svg/eNorSEzOTi1JyUxMV6jmUlAw0DW2UvBITUxJLbJWQAL6-grO-XnFJYl5JVYKBhVpqalpyQaJRkAdJlYKIZUFqQrRRfkliSWptkbmBrHWEB0BYLPB0kCFplYKPql56SUZaEqBCl0SSxKBkkA5oDotCDc6JzXP1jTWGtkJIAmwCmcPbwwLIY7MSE3OLi7N5arlAgALMjve)

Inspired by
This project was inspired by the work in the  [metekcity](https://github.com/hertzg/metekcity/tree/master) repository. Special thanks to the original contributors for laying the foundation.

