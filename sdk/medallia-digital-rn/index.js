import {
  NativeEventEmitter,
  NativeModules,
  DeviceEventEmitter,
  Platform,
} from 'react-native';

const { MedalliaDigitalModule } = NativeModules;

// Consts
const eventEmitter =
  Platform.OS === 'ios'
    ? new NativeEventEmitter(MedalliaDigitalModule)
    : DeviceEventEmitter;
const callbacks = {
  INTERCEPT_CALLBACK: 'setInterceptCallback',
  FEEDBACK_CALLBACK: 'setFeedbackCallback',
  FORM_CALLBACK: 'setFormCallback',
  CUSTOM_INTERCEPT: 'setCustomInterceptCallback',
};

export class MedalliaDigital {
  // Public Consts
  static formCallbacksEvents = {
    FORM_SUBMITTED: 'onFormSubmitted',
    FORM_DISMISSED: 'onFormDismissed',
    FORM_CLOSED: 'onFormClosed',
    FORM_DISPLAYED: 'onFormDisplayed',
    FORM_EXTERNAL_URL_BLOCKED: 'onFormExternalUrlBlocked',
    FORM_LINK_SELECTED: 'onFormLinkSelected',
    FORM_THANK_YOU_PROMPT: 'onFormThankYouPrompt',
  };

  static interceptCallbacksEvents = {
    INTERCEPT_DISPLAYED: 'onInterceptDisplayed',
    INTERCEPT_ACCEPTED: 'onInterceptAccepted',
    INTERCEPT_DECLINED: 'onInterceptDeclined',
    INTERCEPT_DEFERRED: 'onInterceptDeferred',
    INTERCEPT_CLOSED: 'onInterceptClosed',
    INTERCEPT_TRIGGER_IN_APP_REVIEW: 'onInterceptTriggerInAppReview',
  };

  static feedbackCallbacksEvents = {
    FEEDBACK_SUBMITTED: 'onFeedbackSubmitted',
  };

  static logLevel = {
    OFF: 'OFF',
    FATAL: 'FATAL',
    ERROR: 'ERROR',
    WARN: 'WARN',
    INFO: 'INFO',
    DEBUG: 'DEBUG',
  };

  static actionType = {
    ACCEPTED: 'ACCEPTED',
    DECLINED: 'DECLINED',
    DEFERRED: 'DEFERRED',
    SKIPPED: 'SKIPPED',
  };

  static customInterceptCallbacksEvents = {
    TARGET_EVALUATION_SUCCESS: 'onTargetEvaluationSuccess',
  };

  // Public APIs
  static initialize = (token) => {
    try {
      return MedalliaDigitalModule.initialize(token);
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };

  static showForm = (formId) => {
    try {
      return MedalliaDigitalModule.showForm(formId);
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };

  static handleNotification = (formId) => {
    try {
      return MedalliaDigitalModule.handleNotification(formId);
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };

  static setCustomParameters = (params) => {
    MedalliaDigitalModule.setCustomParameters(params);
  };

  static setLogLevel = (logLevel) => {
    MedalliaDigitalModule.setLogLevel(logLevel);
  };

  static disableIntercept = () => {
    MedalliaDigitalModule.disableIntercept();
  };

  static enableIntercept = () => {
    MedalliaDigitalModule.enableIntercept();
  };

  static setCustomAppearance = (appearance) => {
    MedalliaDigitalModule.setCustomAppearance(appearance);
  };

  static setUserId = (userId) => {
    MedalliaDigitalModule.setUserId(userId);
  };

  static closeEngagement = () => {
    try {
      return MedalliaDigitalModule.closeEngagement();
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };

  static setDebugForm = (debug) => {
    MedalliaDigitalModule.setDebugForm(debug);
  };

  static stopSDK = (clearData) => {
    MedalliaDigitalModule.stopSDK(clearData);
  };

  static revertStopSDK = () => {
    MedalliaDigitalModule.revertStopSDK();
  };

  static customInterceptTrigger = (engagementId, actionType) => {
    try {
      return MedalliaDigitalModule.customInterceptTrigger(
        engagementId,
        actionType
      );
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };

  static setInterceptCallback = (func) => {
    MedalliaDigitalModule.setInterceptCallback();
    eventEmitter.addListener(callbacks.INTERCEPT_CALLBACK, func);
  };

  static setFeedbackCallback = (func) => {
    MedalliaDigitalModule.setFeedbackCallback();
    eventEmitter.addListener(callbacks.FEEDBACK_CALLBACK, func);
  };

  static setFormCallback = (func) => {
    MedalliaDigitalModule.setFormCallback();
    eventEmitter.addListener(callbacks.FORM_CALLBACK, func);
  };

  static setCustomInterceptCallback = (func) => {
    MedalliaDigitalModule.setCustomInterceptCallback();
    eventEmitter.addListener(callbacks.CUSTOM_INTERCEPT, func);
  };

  static updateCustomLocale = (locale) => {
    try {
      return MedalliaDigitalModule.updateCustomLocale(locale);
    } catch (exception) {
      console.log(exception.message);
      return exception;
    }
  };
}

module.exports = {
  MedalliaDigital,
};
