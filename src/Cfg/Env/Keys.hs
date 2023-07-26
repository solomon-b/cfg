module Cfg.Env.Keys where

import Data.Text (Text)
import Data.Tree (Tree, foldTree)
import Cfg.Source (RootConfig (..))
import Data.List (intersperse)

-- | @since 0.0.1.0
getEnvKey :: Text -> [Text] -> Text
getEnvKey sep = foldr mappend "" . intersperse sep

-- | @since 0.0.1.0
getKeys :: Tree Text -> [[Text]]
getKeys = foldTree f
 where
  f :: Text -> [[[Text]]] -> [[Text]]
  f label [] = [[label]]
  f label xs = concat $ fmap (label :) <$> xs

-- | @since 0.0.1.0
showEnvKeys' :: Text -> Tree Text -> [Text]
showEnvKeys' sep tree = getEnvKey sep <$> getKeys tree

-- | @since 0.0.1.0
showEnvKeys :: forall a. (RootConfig a) => Text -> [Text]
showEnvKeys sep = getEnvKey sep <$> (getKeys $ toRootConfig @a)
