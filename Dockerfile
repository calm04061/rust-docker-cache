ARG REPO=registry.cn-beijing.aliyuncs.com/dinghan
FROM ${REPO}/cloud:builder as builder
ADD . /src/
RUN --mount=type=cache,source=/root/.cargo/registry,target=/root/.cargo/registry \
 --mount=type=cache,source=/src/target,target=/src/target,sharing=locked \
 cargo install --path .

FROM ${REPO}/cloud:base
COPY --from=builder /root/.cargo/bin/rust-docker-cache /app/
