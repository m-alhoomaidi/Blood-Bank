// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyC-WrbSA7o6lA6yTw98MTRHKhU7bH8hKcc",
    authDomain: "blood-bank-df3f9.firebaseapp.com",
    projectId: "blood-bank-df3f9",
    storageBucket: "blood-bank-df3f9.appspot.com",
    messagingSenderId: "961191689727",
    appId: "1:961191689727:web:2e60aff3874ce4b1ee3bca",
    measurementId: "G-3H704K1FH8"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const db = getFirestore(app)