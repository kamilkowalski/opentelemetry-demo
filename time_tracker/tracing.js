const opentelemetry = require("@opentelemetry/sdk-node");
const { CollectorTraceExporter } = require("@opentelemetry/exporter-collector");
const { getNodeAutoInstrumentations } = require("@opentelemetry/auto-instrumentations-node");
const { Resource } = require('@opentelemetry/resources');
const { SemanticResourceAttributes } = require('@opentelemetry/semantic-conventions');
const { OTEL_COLLECTOR_HOST, OTEL_COLLECTOR_PORT } = process.env;

let traceExporter;

if (OTEL_COLLECTOR_HOST && OTEL_COLLECTOR_PORT) {
  traceExporter = new CollectorTraceExporter({
    url: `http://${OTEL_COLLECTOR_HOST}:${OTEL_COLLECTOR_PORT}/v1/traces`
  });
} else {
  traceExporter = new opentelemetry.tracing.ConsoleSpanExporter();
}

const sdk = new opentelemetry.NodeSDK({
  resource: new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]: 'time_tracker',
  }),
  traceExporter,
  instrumentations: [getNodeAutoInstrumentations()]
});

sdk.start();
