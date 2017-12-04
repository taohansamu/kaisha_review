

        App.notifications = App.cable.subscriptions.create(
            {channel: 'NotificationChannel', user_id: Cookies.get('current_user_id')},
            {
                connected: function () {
                    console.log('connected')
                },
                disconnected: function () {
                },
                received: function (data) {
                    console.log('new notification arrived');
                    $.notify({
                        message:data.message,
                        url:data.url
                    })
                    $('#notifications_in_header').empty().html(data.notifications);
                    $('.dropdown_notification').dropdown();
                }
            })


/*
*
* */