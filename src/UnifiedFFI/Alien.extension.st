Extension { #name : #Alien }

{ #category : #'*UnifiedFFI' }
Alien >> integerAt: byteOffset size: size signed: signed [

	^ (ExternalAddress fromAddress: self address) integerAt: byteOffset size: size signed: signed
]
