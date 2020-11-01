window.plaidLink = (token, callback) => {
    return Plaid.create({
        // Make a request to your server to fetch a new link_token.
        token,
        onLoad: function () {
            // The Link module finished loading.
        },
        onSuccess: function (public_token, metadata) {
            // The onSuccess function is called when the user has
            // successfully authenticated and selected an account to
            // use.
            //
            // When called, you will send the public_token
            // and the selected account ID, metadata.account_id,
            // to your backend app server.
            //
            // sendDataToBackendServer({
            //   public_token: public_token,
            //   account_id: metadata.account_id
            // });
            callback(public_token, metadata.account_id)
            /*fetch('localhost:3000/exchange', {
                method: 'POST',
                body: {
                    public_token: public_token,
                    accounts: metadata.accounts,
                    institution: metadata.institution,
                    link_session_id: metadata.link_session_id,
                },
            });
            console.log('Public Token: ' + public_token);
            console.log('Customer-selected account ID: ' + metadata.account_id);*/
        },
        onExit: function (err, metadata) {
            // The user exited the Link flow.
            if (err != null) {
                // The user encountered a Plaid API error
                // prior to exiting.
            }
            // metadata contains information about the institution
            // that the user selected and the most recent
            // API request IDs.
            // Storing this information can be helpful for support.
        },
    });
}