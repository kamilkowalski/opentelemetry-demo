const express = require("express");
const opentelemetry = require('@opentelemetry/api');

const app = express();
const port = process.env.PORT || 3000;
const tracer = opentelemetry.trace.getTracer('timeTrackingTracer');

const doWork = () => {
    const span = tracer.startSpan('doWork()');
    console.log("Working super hard...")
    for (let i = 0; i <= 10e6; i += 1) {
    }
    span.end();
};

app.post("/cluckIn", (req, res) => {
    doWork();
    console.log("Got a cluck-in request!");
    res.status(201).end();
});

app.listen(port, () => {
    console.log(`Time tracker listening at http://localhost:${port}`);
});
