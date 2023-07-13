import { CodecError, Decoder } from '@nsr/codec'
import { Either, Task } from '@nsr/effect'
import { CacheError } from './CacheError'

export interface Cache {
  has(key: string): Task<Either<CacheError, boolean>>
  get<E extends Error, A>(
    key: string,
    decoder: Decoder<A>,
    onMiss: () => Task<Either<E, A>>,
  ): Task<Either<E | CacheError | CodecError, A>>
  delete(key: string): Task<Either<CacheError, boolean>>
  clear(): Task<Either<CacheError, void>>
}
