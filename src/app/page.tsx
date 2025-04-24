import { MyLogger } from '@/lib/MyLogger'

export default function Home () {
  MyLogger.info('Hello world')
  return <h1>Hola mundo</h1>
}
