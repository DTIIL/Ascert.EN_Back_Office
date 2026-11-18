package com.ascerten.backofficeapplication.dto;

import java.time.OffsetDateTime;

public record FactoryProvisioningDeviceDTO(
        String deviceId,
        String status,
        String publicKey,
        String vendorAttestation,
        String qcData,
        Integer firmwareVersion,
        OffsetDateTime createdAt,
        OffsetDateTime updatedAt,
        String lifecycle,
        Integer bindingNo,
        Integer keygenCounter,
        Integer signCounter
) {
}