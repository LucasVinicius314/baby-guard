declare global {
  namespace NodeJS {
    interface ProcessEnv {
      COM_PATH: string
      API_PROTOCOL: string
      API_AUTHORITY: string
    }
  }
}

export {}
