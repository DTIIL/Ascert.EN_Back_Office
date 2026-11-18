package com.ascerten.backofficeapplication.service;

import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ascerten.backofficeapplication.dto.FactoryProvisioningDeviceDTO;
import com.ascerten.backofficeapplication.entity.QdsdDetails;
import com.ascerten.backofficeapplication.repository.QdsdDetailsRepository;
import com.ascerten.backofficeapplication.exception.ResourceNotFoundException;

@Service
public class FactoryProvisioningService {

    private final QdsdDetailsRepository repository;

    public FactoryProvisioningService(QdsdDetailsRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<FactoryProvisioningDeviceDTO> getAllDevices() {

        return repository.findAllByOrderByCreatedDateDesc()
                .stream()
                .map(this::convertToDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public FactoryProvisioningDeviceDTO getDevice(String deviceId) {

        QdsdDetails device = repository.findByQdsdId(deviceId)
                .orElseThrow(() ->
                        new ResourceNotFoundException(
                                "Device not found: " + deviceId
                        ));

        return convertToDTO(device);
    }

    private FactoryProvisioningDeviceDTO convertToDTO(QdsdDetails device) {

        return new FactoryProvisioningDeviceDTO(
                device.getQdsdId(),
                device.getStatus() != null
                        ? device.getStatus().getStatus()
                        : "Unknown",
                encode(device.getPublicKey()),
                encode(device.getVendorAttestation()),
                device.getQcData(),
                device.getFirmwareVersion(),
                device.getCreatedDate(),
                device.getUpdatedDate(),
                device.getLifecycle(),
                device.getBindingNo(),
                device.getKeygenCounter(),
                device.getSignCounter()
        );
    }

    private String encode(byte[] value) {
        return value == null
                ? null
                : Base64.getEncoder().encodeToString(value);
    }
}