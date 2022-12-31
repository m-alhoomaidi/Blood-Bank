import { createContext, useContext, useState, useReducer, useRef } from 'react';
import PropTypes from 'prop-types';
import { useRouter } from 'next/router'
const HANDLERS = {
    INITIALIZE: 'INITIALIZE',
    SIGN_IN: 'SIGN_IN',
    SIGN_OUT: 'SIGN_OUT',
    UPDATE_USER: 'UPDATE_USER'
};

const initialState = {
    isAuthenticated: false,
    isLoading: false,
    user: {}
};

const handlers = {
    [HANDLERS.INITIALIZE]: (state, action) => {
        const user = action.payload;

        return {
            ...state,
            ...(
                // if payload (user) is provided, then is authenticated
                user
                    ? ({
                        isAuthenticated: true,
                        isLoading: false,
                        user
                    })
                    : ({
                        isLoading: false
                    })
            )
        };
    },
    [HANDLERS.SIGN_IN]: (state, action) => {
        const user = action.payload;
        return {
            ...state,
            isAuthenticated: true,
            user
        };
    },
    [HANDLERS.SIGN_OUT]: (state) => {
        return {
            ...state,
            isAuthenticated: false,
            user: null
        };
    },
    [HANDLERS.UPDATE_USER]: (state, action) => {
        const user = action.payload;
        return {
            ...state,
            isAuthenticated: true,
            user
        };
    }
};

const reducer = (state, action) => (
    handlers[action.type] ? handlers[action.type](state, action) : state
);

// The role of this context is to propagate authentication state through the App tree.

export const AuthContext = createContext({ undefined });

export const AuthProvider = (props) => {
    const { children } = props;
    const [state, dispatch] = useReducer(reducer, initialState);
    const initialized = useRef(false);
    const router = useRouter()

    const initialize = async () => {
        // Prevent from calling twice in development mode with React.StrictMode enabled
        if (initialized.current) {
            return;
        }

        initialized.current = true;

    };


    const signIn = async ({ email, password }) => {
        const res = await fetch(`${process.env.NEXT_PUBLIC_NEXT_URL}/api/auth/login`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email,
                password
            })
        })
        const data = await res.json()
        if (!res.ok) {
            return data
        }
        if (res.ok) {
            dispatch({
                type: HANDLERS.SIGN_IN,
                payload: data.user
            });
            router.push('/')
            return data
        }

    };

    const signOut = async () => {
        const res = await fetch(`${process.env.NEXT_PUBLIC_NEXT_URL}/api/auth/logout`, {
            method: 'POST',
        })

        if (res.ok) {
            router.push('/sign-in')
        }

        dispatch({
            type: HANDLERS.SIGN_OUT
        });
    };

    const updateUser = (user) => {
        dispatch({
            type: HANDLERS.UPDATE_USER,
            payload: user

        })
    }

    const checkAuthenticated = async (user) => {
        dispatch({
            type: HANDLERS.SIGN_IN,
            payload: user
        });
    }

    return (
        <AuthContext.Provider
            value={{
                ...state,
                user: state.user,
                signIn,
                signOut,
                checkAuthenticated,
                updateUser
            }}
        >

            {children}
        </AuthContext.Provider>
    );
};

AuthProvider.propTypes = {
    children: PropTypes.node
};

export const AuthConsumer = AuthContext.Consumer;

export const useAuthContext = () => useContext(AuthContext);
