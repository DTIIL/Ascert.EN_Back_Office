package com.ascert.backoffice.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

@Component
public class SampleData {

    private final List<Map<String, Object>> qdsdDevices;
    private final List<Map<String, Object>> factoryDevices;
    private final List<Map<String, Object>> reportRows;
    private final List<Map<String, Object>> users;

    public SampleData() {
        ObjectMapper mapper = new ObjectMapper();
        try (InputStream in = new ClassPathResource("data/sample-data.json").getInputStream()) {
            JsonNode root = mapper.readTree(in);
            qdsdDevices = readList(mapper, root.get("dummyData"));
            factoryDevices = readList(mapper, root.get("factoryProvisioningData"));
            reportRows = readList(mapper, root.get("rowDataProvisioningReport"));
            users = readList(mapper, root.get("dummyUsers"));
        } catch (IOException ex) {
            throw new IllegalStateException("Could not load sample-data.json", ex);
        }
    }

    public List<Map<String, Object>> getQdsdDevices() {
        return qdsdDevices;
    }

    public List<Map<String, Object>> getFactoryDevices() {
        return factoryDevices;
    }

    public List<Map<String, Object>> getReportRows() {
        return reportRows;
    }

    public List<Map<String, Object>> getUsers() {
        return users;
    }

    private static List<Map<String, Object>> readList(ObjectMapper mapper, JsonNode node) {
        if (node == null || node.isNull()) {
            return Collections.emptyList();
        }
        return mapper.convertValue(node, new TypeReference<List<Map<String, Object>>>() {});
    }
}
