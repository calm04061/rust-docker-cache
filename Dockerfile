ARG REPO=registry.cn-beijing.aliyuncs.com/dinghan
FROM ${REPO}/cloud:builder as builder
ADD . /src/
RUN --mount=type=cache,target=/root/.cargo/registry \
 --mount=type=cache,target=/src/target,sharing=locked \
 cargo build --release
RUN ls /src
RUN ls /src/target
RUN ls /src/target/release

FROM ${REPO}/cloud:base
COPY --from=builder /src/target/release/rust-docker-cache /app/
