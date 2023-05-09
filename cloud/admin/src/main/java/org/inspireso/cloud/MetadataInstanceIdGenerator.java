/*
 * Copyright 2023 inspireso.org. All rights reserved.
 * Use of this source code is governed by a MIT style
 * license that can be found in the LICENSE file.
 */

package org.inspireso.cloud;

import de.codecentric.boot.admin.server.domain.values.InstanceId;
import de.codecentric.boot.admin.server.domain.values.Registration;
import de.codecentric.boot.admin.server.services.InstanceIdGenerator;
import org.springframework.util.StringUtils;

class MetadataInstanceIdGenerator implements InstanceIdGenerator {
    private final InstanceIdGenerator fallbackIdGenerator;

    public MetadataInstanceIdGenerator(InstanceIdGenerator fallbackIdGenerator) {
        this.fallbackIdGenerator = fallbackIdGenerator;
    }

    @Override
    public InstanceId generateId(Registration registration) {
        String instanceId = registration.getMetadata().get("instanceId");
        if (StringUtils.hasText(instanceId)) {
            return InstanceId.of(instanceId);
        }
        return fallbackIdGenerator.generateId(registration);
    }
}
