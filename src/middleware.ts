import { NextRequest, NextResponse } from 'next/server'

export function middleware (_req: NextRequest): NextResponse<unknown> {
  return NextResponse.next()
}
