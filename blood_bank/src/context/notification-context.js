import { FC, useState, useEffect, useCallback, useContext, createContext,useReducer,useRef } from "react";
import { app, db } from '../utils/firebase';
import PropTypes from 'prop-types';
import { getMessaging, getToken, onMessage } from 'firebase/messaging';
import { doc, getDoc } from "firebase/firestore";


const HANDLERS = {
    INITIALIZE: 'INITIALIZE',
    NOTIFICATION_DONORS:' NOTIFICATION_DONORS',
};

const initialState = {
    isAuthenticated: false,
    isLoading: false,
   notificationDonors :{}
};
const handlers = {
    [HANDLERS.INITIALIZE]: (state, action) => {
        const notificationDonors = action.payload;
        return {
            ...state,
            ...(
                // if payload (user) is provided, then is authenticated
                notificationDonors
                    ? ({
                        isAuthenticated: true,
                        isLoading: false,
                        notificationDonors
                    })
                    : ({
                        isLoading: false
                    })
            )
        };
    },
    [HANDLERS.NOTIFICATION_DONORS]: (state, action) => {
        const notificationDonors = action.payload;
        return {
            ...state,
            isAuthenticated: true,
            notificationDonors,
        };
    },
};
const reducer = (state, action) => (
    handlers[action.type] ? handlers[action.type](state, action) : state
);



export const NotificationContext = createContext();
export const NotificationProvider = (props) => {
    
    const { children } = props;
    const [state, dispatch] = useReducer(reducer, initialState);
    const initialized = useRef(false);

    const initialize = async () => {
        if (initialized.current) {
            return;
        }

        initialized.current = true;

    };

    // const [FCMToken, setFCMToken] = useState('');
    // let messaging = async () => { return await getMessaging(app) }

    // useEffect(() => {

    //     requestForToken();
    // }, [])

    // const requestForToken = async () => {
    //     try {
    //         const currentToken = await getToken(await messaging(), { vapidKey: "BKwsPLK4i41_RA0Gy81vw5ZhLYzGXXoCBaHCWt1pMBqbDN_fSNnhjMpsQeEYc3EmDDMAqyPfefNhtPhj20q1vpU" });
    //         if (currentToken) {
    //             setFCMToken(currentToken)
    //             console.log('current token for client: ', currentToken);
    //             return currentToken
    //         } else {
    //             // Show permission request UI
    //             console.log('No registration token available. Request permission to generate one.');
    //         }
    //     } catch (err) {
    //         console.log('An error occurred while retrieving token. ', err);
    //     }
    // };

    // const onMessageListener = async () =>
    //     new Promise(async (resolve) => {
    //         onMessage(await messaging(), (payload) => {
    //             resolve(payload);
    //         });
    //     });
    const SendNotificationDonors = (notificationDonors)=>{
        dispatch({
           type: HANDLERS.NOTIFICATION_DONORS,
           payload: notificationDonors,
        })
        console.log(notificationDonors);
    }
    const checkIfnotificationenticated = async () => {
        const id=localStorage.getItem("uid");
        const docRef = doc(db, "donors",id);
        const docSnap = await getDoc(docRef);
        const NotDonors = docSnap.data(); 
        SendNotificationDonors(NotDonors);
        if (docSnap.exists()) {
            dispatch({
                        type:HANDLERS.NOTIFICATION_DONORS,
                        payload: NotDonors
                    });
                    return true
          } 
        else
            throw Error("there is an error")
        }

    return (
        <NotificationContext.Provider value={{
            ...state,
            notificationDonors: state.notificationDonors,
            checkIfnotificationenticated,
            SendNotificationDonors,

        }}>{props.children}</NotificationContext.Provider>

    );
};

NotificationProvider.propTypes = {
    children: PropTypes.node
};
export const NotificationConsumer = NotificationContext.Consumer;

export const useNotificationContext = () => useContext(NotificationContext);

// export default SocketProvider;
