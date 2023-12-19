ARG REPO=registry.cn-beijing.aliyuncs.com/dinghan
FROM ${REPO}/cloud:builder as builder
ADD . /src/
RUN --mount=type=cache,target=/root/.cargo/registry \
 --mount=type=cache,target=/src/target,sharing=locked \
 cargo install --path .
RUN ls /root/.cargo/bin/

FROM ${REPO}/cloud:base
COPY --from=builder /root/.cargo/bin/rust-docker-cache /app/
