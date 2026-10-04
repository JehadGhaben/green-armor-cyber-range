# Lab Safety

This project intentionally contains simple training credentials and isolated services.

- Run it locally for training.
- No service publishes a host port in `compose.yaml`.
- The internal Docker network is marked `internal: true`.
- Do not reuse the included passwords elsewhere.
- Stop the lab when training is complete.
