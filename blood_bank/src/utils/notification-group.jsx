export const SendNotification = async (tokens) => {
    const title = "حالة حرجة";
  const body="زمرة الدم";
  console.log(tokens);
    return await fetch('https://fcm.googleapis.com/fcm/send', {
        method: "POST",
        headers: {
            Authorization: 'key=AAAA38t9Pf8:APA91bHd0hEzCkV3I2p-fNMcOefQ1qPB33maAXXHMdf8fYy-oAkbyBBkGd4qKNR50j8P8QHb0gJwWOG4ejoGpbwaZw526MHofn3kb4HsQfyGW2j5ooAPIxdVtyFSC6wX9-JiAtspHITX',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            title,
            body,
            to: tokens
        })
    }).then((res) => {
        console.log(res)
       
    })
        .catch((err) => {
            console.log(err)
        })

  }