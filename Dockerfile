FROM quay.io/keycloak/keycloak:latest

ADD --chown=keycloak:keycloak --chmod=644 https://github.com/klausbetz/apple-identity-provider-keycloak/releases/download/1.16.0/apple-identity-provider-1.14.0.jar /opt/keycloak/providers/apple-identity-provider-1.7.0.jar
ADD --chown=keycloak:keycloak --chmod=644 keycloak-theme-for-kc-all-other-versions.jar /opt/keycloak/providers/keycloak-theme-for-kc-all-other-versions.jar
ADD --chown=keycloak:keycloak --chmod=644 fittime-keycloak-26.jar /opt/keycloak/providers/fittime-keycloak-26.jar

# Setting the build parameter for the database:
ENV KC_DB=postgres

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

RUN touch -m --date=@1743465600 /opt/keycloak/providers/*

# To be able to use the image with the Keycloak Operator, it needs to be optimized, which requires Keycloak's build step:
RUN /opt/keycloak/bin/kc.sh build
