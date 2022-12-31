import { FC, useState, useEffect, useCallback, useContext, createContext } from "react";
import { app } from '../utils/firebase'
import { getMessaging, getToken, onMessage } from 'firebase/messaging';

export const NotificationContext = createContext();

export const NotificationProvider = (props) => {
    const [FCMToken, setFCMToken] = useState('');
    let messaging = async () => { return await getMessaging(app) }

    useEffect(() => {

        requestForToken();
    }, [])

    const requestForToken = async () => {
        try {
            const currentToken = await getToken(await messaging(), { vapidKey: "BKwsPLK4i41_RA0Gy81vw5ZhLYzGXXoCBaHCWt1pMBqbDN_fSNnhjMpsQeEYc3EmDDMAqyPfefNhtPhj20q1vpU" });
            if (currentToken) {
                setFCMToken(currentToken)
                console.log('current token for client: ', currentToken);
                return currentToken
            } else {
                // Show permission request UI
                console.log('No registration token available. Request permission to generate one.');
            }
        } catch (err) {
            console.log('An error occurred while retrieving token. ', err);
        }
    };

    const onMessageListener = async () =>
        new Promise(async (resolve) => {
            onMessage(await messaging(), (payload) => {
                resolve(payload);
            });
        });


    return (
        <NotificationContext.Provider value={{
            app,
            FCMToken,
            requestForToken,
            onMessageListener

        }}>{props.children}</NotificationContext.Provider>

    );
};



export const useNotificationContext = () => useContext(NotificationContext);

// export default SocketProvider;
