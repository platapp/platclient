const express = require('express')
const app = express()
const port = 3000
const bodyParser = require('body-parser')
app.use(bodyParser.json())
const URL = 'https://api-sandbox.dwolla.com/'
const dwolla = require('dwolla-v2')
const plaid = require('plaid')
const environment = 'sandbox' //todo!! add as env 
const APP_NAME = 'Plat'
// Navigate to https://dashboard.dwolla.com/applications (production) or https://dashboard-sandbox.dwolla.com/applications (Sandbox) for your application key and secret.
const { key: dKey, secret: dSecret } = require('./dwolla-secrets.json')
const { key: pKey, secret: pSecret } = require('./plaid-secrets.json')
const dClient = new dwolla.Client({
    key: dKey,
    secret: dSecret,
    environment
});

const pClient = new plaid.Client({
    clientID: pKey,
    secret: pSecret,
    env: plaid.environments.sandbox,
});
// create a token

app.post('/customers', (req, res) => {
    dClient.auth.client()
        .then(appToken => appToken.post('customers', req.body))
        .then(res => res.headers.get('location'))
        .then(location => res.send({ location }))
        .catch(error => res.status(401).send({ error }))
})

app.get('/link_token/:id', (req, res) => {
    const { id } = req.params
    pClient.createLinkToken({
        user: {
            client_user_id: id,
        },
        client_name: APP_NAME,
        products: ['auth'],
        country_codes: ['US'],
        language: 'en',
        webhook: 'https://webhook.sample.com',
    }).then(({ link_token }) => res.send({ link_token })).catch(res.send)
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

/*
const
var requestBody = {
    firstName: 'Jane',
    lastName: 'Merchant',
    email: 'jmerchant@nomail.net',
    type: 'receive-only',
    businessName: 'Jane Corp llc',
    ipAddress: '99.99.99.99'
};

appToken
    .post('customers', requestBody)
    .then(res => res.headers.get('location')); */