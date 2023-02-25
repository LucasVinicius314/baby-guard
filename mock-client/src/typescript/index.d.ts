declare global {
  namespace NodeJS {
    interface ProcessEnv {
      COM_PATH: string
    }
  }
}

export {}
