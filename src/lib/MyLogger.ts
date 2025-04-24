import pino from 'pino'

export class MyLogger {
  static logger: pino.Logger | undefined = undefined

  static info (message: string): void {
    if (MyLogger.logger === undefined) {
      MyLogger.logger = MyLogger.initLogger()
    }
    MyLogger.logger.info(message)
  }

  private static initLogger (): pino.Logger {
    const currentIsoDate = new Date().toISOString().split('T')[0]
    return pino(
      {
        level: 'info',
        base: undefined,
        timestamp: pino.stdTimeFunctions.isoTime,
        messageKey: 'm',
      },
      pino.destination({
        dest: `logs/access-${currentIsoDate}.log`,
        sync: false,
        mkdir: true,
      }),
    )
  }
}
