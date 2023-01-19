import { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import PropTypes from 'prop-types';
import { useAuthContext } from './auth-context';
import { getOrigin } from '../utils/get-origin';
// import { useNotificationContext } from '../contexts/notification-context';
export const AuthGuard = (props) => {
    const { children } = props;
    const { checkIfAuthenticated, user, signIn } = useAuthContext();
    // const { requestForToken } = useNotificationContext();
    const ignore = useRef(false);
    const [checked, setChecked] = useState(false);
    const [FCMToken, setFCMToken] = useState('');
    const navigate = useNavigate()
    useEffect(
        () => {
            const checkAuth = async () => {
                const username = localStorage.getItem('blood-bank-username')
                const password = localStorage.getItem('blood-bank-password')
                checkIfAuthenticated()
                    .then((data) => {
                         setChecked(true)
                        // const path = getOrigin()
                        // if (path == 'login')
                        //     navigate('/')
                    })
                    .catch((err) => {
                        console.log(err)
                    })
            }
            if (!checked) {
                checkAuth();
            }
        },
        []
    );

    // if (!checked) {
    //     return null;
    // }

    // If got here, it means that the redirect did not occur, and that tells us that the user is
    // authenticated / authorized.

    return children;
};

AuthGuard.propTypes = {
    children: PropTypes.node
};
